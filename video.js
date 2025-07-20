document.addEventListener("DOMContentLoaded", function () {
    var videoContainer = document.getElementById("YouTubeBackgroundVideoPlayer");

    if (!videoContainer) {
        console.error("Elemento 'YouTubeBackgroundVideoPlayer' não encontrado.");
        return;
    }

    var video = document.createElement("video");
    video.id = "localVideoPlayer";
    video.src = "nui://vrp/loading/foxzin.webm"; // Novo formato
    video.autoplay = true;
    video.loop = false; // 🔄 Loop manual para evitar bugs
    video.muted = true;
    video.playsInline = true;
    video.style.width = "100%";
    video.style.height = "100%";
    video.style.position = "absolute";
    video.style.top = "0";
    video.style.left = "0";
    video.style.objectFit = "cover";

    videoContainer.appendChild(video);

    // Depuração para verificar carregamento
    video.addEventListener("canplay", function () {
        console.log("🎥 Vídeo carregado com sucesso!");
    });

    video.addEventListener("error", function () {
        console.error("⚠️ Erro ao carregar o vídeo. Verifique o caminho:", video.src);
    });

    // 🔄 Reiniciar manualmente caso o loop não funcione
    video.addEventListener("ended", function () {
        console.warn("🔁 Vídeo chegou ao fim, reiniciando...");
        setTimeout(() => {
            video.currentTime = 0;
            video.play().catch(error => console.error("❌ Erro ao reiniciar o vídeo:", error));
        }, 500);
    });

    video.play().catch(error => console.error("❌ Erro ao iniciar o vídeo:", error));
});
