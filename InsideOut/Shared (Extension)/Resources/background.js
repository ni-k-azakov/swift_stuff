var rangeValue = 0.3;
var language = "de";

chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received request: ", request);
    if (request === 'get_range') {
        sendResponse(rangeValue);
    } else if (request.type === "set_range") {
        rangeValue = request.value;
    } else if (request == 'get_language') {
        sendResponse(language);
    } else if (request.type === 'set_language') {
        language = request.value;
    }
    // else if (request === 'run_content_js') {
    //     isContentJsOn = true;
    // }
});

async function runContentJS() {
    let tab = await browser.tabs.getCurrent();
    browser.scripting.executeScript({
        target: { tabId: tab.id },
        files: [ "content.js" ]
    });
}