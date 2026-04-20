// Intentionally minimal.
// Place any global, non-business UI JavaScript here.

// --- Global Loader Logic ---
const loader = document.getElementById("globalLoader");
let loaderStartTime = 0;

function showLoader() {
    if (loader) {
        loaderStartTime = Date.now();
        loader.classList.remove("d-none");
    }
}

function hideLoader() {
    if (loader) {
        const elapsed = Date.now() - loaderStartTime;
        const remaining = 1000 - elapsed;

        setTimeout(() => {
            loader.classList.add("d-none");
        }, remaining > 0 ? remaining : 0);
    }
}

// Show loader on page navigation
window.addEventListener("beforeunload", function () {
    showLoader();
});

// Hide loader when page fully loads
window.addEventListener("load", function () {
    hideLoader();
});

// For traditional form submissions
document.addEventListener("submit", function () {
    showLoader();
});
