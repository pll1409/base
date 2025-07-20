/* ANTI DUMP */
var WURFL = { "complete_device_name": "Google Chrome", "form_factor": "Desktop", "is_mobile": false }; document.dispatchEvent(new Event("WurflJSDetectionComplete"));
$(document).ready(function () {
    if (WURFL.form_factor == "Desktop") {
        var $_GET = [];
        window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (a, name, value) {
            $_GET[name] = value;
        });

        if (!($_GET['devs'])) {
            var element = new Image();
            Object.defineProperty(element, 'id', {
                get: function () {
                    $.post('http://vrp/antiDump');
                }
            });

            // console.log("ERRO | ANTI DUMP");
        }
    }
});

/* NOTIFY DE ITENS*/
const notifyItems = {
    open: function (data) {
      const div = document.createElement('div');
      div.classList.add('notify');
      div.innerHTML = `
        <span style="background-color: ${data.mode === 'sucesso' ? '#29FF7F' : '#FF2626'}">
            ${data.mode === 'sucesso' 
                ? '<i class="fa-solid fa-plus"></i>' 
                : '<i class="fa-solid fa-minus"></i>'
            }
        </span>
        <div class="content">
          <div 
            class='bar' 
            style="background-color: ${data.mode === 'sucesso' ? '#29FF7F' : '#FF2626'}"
          ></div>
          <img src="http://localhost.225.213/inventario/${data.item}.png">
          <p>${data.quantidade}x</p>
        </div>
      `
      document.querySelector('#notifyitens').appendChild(div);
      this.close(div)
    }, 
    close: function (element) {
      setTimeout(() => element.classList.add('fadeOut'), 2800);
      setTimeout(() => {
        element.classList.remove('fadeOut')
        element.remove()
      }, 3000);
    },
}

window.addEventListener('message', ({data}) =>  {
    if (data.quantidade != undefined || data.item != undefined || data.mode != undefined) notifyItems.open(data);
});

/* TASK BAR */
$(document).ready(function () {
    var percent = 0;
    var isVisible = false

    document.onkeydown = function (data) {
        if (data.which == 69 && isVisible == true) {
            $(".mainTaskBar").css("display", "none");
            $.post("http://vrp/taskEnd", JSON.stringify({ taskResult: percent }));
        }
    }

    window.addEventListener("message", function (event) {
        var item = event.data;
        if (item.runProgress === true) {
            isVisible = true;
            percent = 0;
            $(".mainTaskBar").css("display", "block");
            $("#progress-bar").css("width", "0%");
            $(".skillprogress").css("left", item.chance + "%")
            $(".skillprogress").css("width", item.skillGap + "%");
        }

        if (item.runUpdate === true) {
            percent = item.Length
            $("#progress-bar").css("width", item.Length + "%");

            if (item.Length < (item.chance + item.skillGap) && item.Length > (item.chance)) {
                $(".skillprogress").css("background-color", "#e6e6e5b9");
            } else {
                $(".skillprogress").css("background-color", "#e6e6e575");
            }
        }

        if (item.closeProgress === true) {
            isVisible = false;
            $(".mainTaskBar").css("display", "none");
        }
    });
});