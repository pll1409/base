const options = {
    moduleCache: {
      vue: Vue
    },
    async getFile(url) {
      
      const res = await fetch(url);
      if ( !res.ok )
        throw Object.assign(new Error(res.statusText + ' ' + url), { res });
      return {
        getContentData: asBinary => asBinary ? res.arrayBuffer() : res.text(),
      }
    },
    addStyle(textContent) {

      const style = Object.assign(document.createElement('style'), { textContent });
      const ref = document.head.getElementsByTagName('style')[0] || null;
      document.head.insertBefore(style, ref);
    },
}

const { loadModule } = window['vue3-sfc-loader'];

const _components = {};
let _templates = "";
let _fixedNuis = {};

scripts.forEach((script) => {
    if(script.visible) {
        _fixedNuis[script.name] = { showing: true }
    };
    _components[script.name] = Vue.defineAsyncComponent(() => loadModule(`./${script.name}/nui/${script.name}.vue`, options));
    _templates = _templates + `<${script.name} ref="${script.name}" ${!script.visible ? `v-show="currentNui === '${script.name}'"` : `v-show="fixedNuis.${script.name}.showing"`}/>`;
});

Vue.createApp({
    data(){
        return {
            currentNui: '',
            fixedNuis: _fixedNuis
        }
    },

    components: _components,
    template: _templates,
    
    methods: {
        SHOW_NUI(params){
            if(params) {
                const [script] = params;
                if(this.fixedNuis[script]) {
                    this.fixedNuis[script].showing = true
                } else {
                    if(this.currentNui !== "") this.CLOSE_NUI([this.currentNui]);
                    this.currentNui = script;
                };
                
                this.$refs[script]?.onOpen();
            }
        },

        UPDATE_NUI(params) {
            const [script,data] = params;
            if(!this.$refs[script]) throw new Error(`Module [ERROR]: the referenced script (${script.toUpperCase()}) is not showing or does not exist`);
            this.$refs[script].onUpdate(data);
        },

        CLOSE_NUI(params){
            if(params){
                const [script] = params;
                if(this.fixedNuis[script]) return this.fixedNuis[script].showing = false;
                this.$refs[script]?.onClose();
            }
            this.currentNui = '';
            this.post("module:close");
        },

        GET_MESSAGES(event){
            if(event){
                const [name,...args] = event.data;
                if(!this[name]) throw new Error(`Module: message action (${name}) not found `);
                this[name](([...args]));
            }
        }
    },

    mounted(){
        window.addEventListener('message', this.GET_MESSAGES);

        window.addEventListener('keydown',(event) =>{
            if( event.keyCode === 27 ) {
                if(this.currentNui) {
                    this.CLOSE_NUI([this.currentNui]);
                }
            }
        })
    },

    beforeDestroy() {
        window.removeEventListener('message', this.GET_MESSAGES);
    },

}).mixin({
    methods: {
        post(name,body){
            if(navigator.onLine) {
                fetch(`http://${window.GetParentResourceName()}/${name}`,{
                    method: "POST",
                    body: JSON.stringify(body || {})
                });
            }
        },

        async request(name,body) {
            if(!navigator.onLine) throw new Error("Module [ERROR]: no internet connection");
            const data = await fetch(`http://${window.GetParentResourceName()}/${name}`, {
                method: "POST",
                body: JSON.stringify(body)
            });
            return data.json();
        },
    },
}).mount("#app");