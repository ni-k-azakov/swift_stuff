document.addEventListener("DOMContentLoaded", function() {
    chrome.runtime.sendMessage("run_content_js");

    const rangeInput = document.getElementById('range_input'); 
    const langSelector = document.getElementById('language_selector');

    chrome.runtime.sendMessage("get_language", response => {
        setLanguage(response);
    });
    chrome.runtime.sendMessage("get_range", response => {
        document.getElementById('percent').innerText = response * 100 + "%";
        setRange(response);
        setGradient(response);
    });

    rangeInput.addEventListener("input", function() {
        document.getElementById('percent').innerText = this.value * 100 + "%";
        setGradient(this.value);
    });
    rangeInput.addEventListener("change", function() {
        chrome.runtime.sendMessage({ type: "set_range", value: this.value });
        rebuild(this.value, langSelector.value);
    });
    langSelector.addEventListener("change", function() {
        chrome.runtime.sendMessage({ type: "set_language", value: this.value });
        rebuild(rangeInput.value, this.value);
    });
});

function setRange(value) {
    document.getElementById('range_input').value = value;
}

function setLanguage(value) {
    document.getElementById('language_selector').value = value;
}

function setGradient(percent) {
    document.getElementById('percent_range').style.background = `linear-gradient(90deg, rgba(179, 246, 85, 0) 0%, rgba(179, 246, 85, 1) ${percent * 100 + percent * 10}%, rgba(179, 246, 85, 0) ${100 + percent * 100}%)`;
}

function rebuild(newPercentage, newLanguage) {
    chrome.tabs.query({currentWindow: true, active: true}, function(tabs) {
        var activeTab = tabs[0];
        chrome.tabs.sendMessage(activeTab.id, {"message": { type: "Update translations", newPercentage: newPercentage, newLanguage: newLanguage }});
    });
}


