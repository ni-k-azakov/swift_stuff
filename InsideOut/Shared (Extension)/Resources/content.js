// let emails = getEmails();
bodyCopy = document.body.innerHTML;

var hint = document.createElement("div");
var hintText = document.createTextNode("Test text");
createHint();

var percentage = 0.5;
var language = "de";
var el_id_counter = 0;


chrome.runtime.sendMessage("get_language", response => {
    language = response;
    chrome.runtime.sendMessage("get_range", response => {
        percentage = response;
        rebuild();
    });
});

chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log(request);
    if (request.message.type === "Update translations") {
        percentage = request.message.newPercentage;
        language = request.message.newLanguage;
        reset();
        rebuild();
    }
});

function reset() {
    // console.log(BodyCopy);
    // console.log(document.body.innerHTML);
    // console.log(BodyCopy);
    let scrollPos = document.body.scrollTop;
    document.body.innerHTML = bodyCopy;
    document.body.scrollTop = scrollPos;
    // let rootNode = document.documentElement;
    // let currentBody = document.body;
    // currentBody.replaceWith(bodyCopy);
    // rootNode.replaceChild(bodyCopy, currentBody);
    el_id_counter = 0;
    createHint();
}

function rebuild() {
    // reset();
    wrapInSpans();
    translate();
    paint();
}

// browser.runtime.sendMessage({type: "Found emails", emails: emails == null ? [""] : emails});

// function getEmails() {
//     let searchIn = document.body.innerHTML;
//     let searchContext = searchIn.toString();
//     let arrayMails = searchContext.match(/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)/gi);
//     return arrayMails;
// }

function wrapInSpans() {
    replaceTextNodes(document.body);
}

function createHint() {
    hint = document.createElement("div");
    hintText = document.createTextNode("Test text");
    hint.setAttribute("style", "\
        position:fixed;\
        top:10px;\
        right: 10px;\
        padding-left: 10px;\
        padding-right: 10px;\
        padding-top: 2px;\
        padding-bottom: 2px;\
        background-color:#293133;\
        color: white;\
        line-height: 1.47em;\
        font-family: sans-serif;\
        z-index:9999999;\
        border-radius:5px;\
        font-weight: bold;\
        letter-spacing: -.022em;\
        font-size: 17px;\
        box-shadow: 0px 2px 5px 0px #293133; \
        opacity: 0;\
        transition-delay: 0s;\
        transition-duration: 0.3s;\
        transition-timing-function: ease;\
    ");
    hint.className = 'untranslatable';

    hint.appendChild(hintText);
    document.body.appendChild(hint);
}

function replaceTextNodes(node) {
    node.childNodes.forEach(function(el) {
        if (el.className == "untranslatable") { return; }
        if (el.nodeType === 3) {
            if (el.nodeValue.trim() !== "") {
                let newNode = modifySentence(el);
                node.replaceChild(newNode, el)
            }
        } else {
            replaceTextNodes(el);
        }
    });
}

function modifySentence(node) {
    let text = node.nodeValue;
    let splitted = text.split(' ').join(' §').split('§');;
    let isCurrentSpan = true;
    let newNode = document.createElement("span");
    for (const index in splitted) {
        if (splitted[index].match(/^[a-zA-Z]+ $/gi)) {
            if (Math.random() <= percentage) {
                if (isCurrentSpan) {
                    if (newNode.lastChild == null) {
                        let spanNode = document.createElement("span");
                        spanNode.setAttribute("id", `easy_learner_${el_id_counter}`);
                        spanNode.setAttribute("data-translation", splitted[index]);

                        spanNode.appendChild(document.createTextNode(splitted[index]));
                        newNode.appendChild(spanNode);
                        el_id_counter += 1;
                        isCurrentSpan = true;
                    } else {
                        let attr = newNode.lastChild.getAttribute("data-translation");
                        newNode.lastChild.setAttribute("data-translation", attr + splitted[index]);
                        newNode.lastChild.appendChild(document.createTextNode(splitted[index]));
                    }
                } else {
                    let spanNode = document.createElement("span");
                    spanNode.setAttribute("id", `easy_learner_${el_id_counter}`);
                    spanNode.setAttribute("data-translation", splitted[index]);

                    spanNode.appendChild(document.createTextNode(splitted[index]));
                    newNode.appendChild(spanNode);
                    el_id_counter += 1;
                    isCurrentSpan = true;
                }
            } else {
                if (isCurrentSpan) {
                    newNode.appendChild(document.createTextNode(splitted[index]));
                    isCurrentSpan = false;
                } else {
                    newNode.lastChild.nodeValue += splitted[index];
                }
            }
        } else {
            if (isCurrentSpan) {
                newNode.appendChild(document.createTextNode(splitted[index]));
                isCurrentSpan = false;
            } else {
                newNode.lastChild.nodeValue += splitted[index];
            }
        }
    }
    return newNode;
}

function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
}

function paint() {
    for (var i = 0; i < el_id_counter; i++) {
        let el = document.getElementById(`easy_learner_${i}`);
        // el.style.color = 'white';
        // el.style.paddingTop = '2px';
        // el.style.paddingBottom = '2px';
        el.style.paddingLeft = '4px';
        el.style.paddingRight = '4px';
        el.style.margin = '2px';
        el.style.border = '2px solid';
        // el.style.borderColor = 'rgba(179, 246, 85, 0.5)';
        // el.style.borderColor = 'rgba(41, 49, 51, 0.5)';
        // el.style.backgroundColor = 'rgba(61, 255, 139, 0.5)';
        el.style.borderRadius = '5px';
        el.style.transitionDelay = '0s';
        el.style.transitionDuration = '0.3s';
        el.style.transitionTimingFunction = 'ease';

        el.onmouseover = function(){
            el.style.backgroundColor = 'rgba(179, 246, 85, 0.5)';
            el.style.borderColor = 'rgba(179, 246, 85, 0.5)';
            el.style.color = 'black';
            hintText.textContent = el.getAttribute("data-translation");
            hint.style.opacity = 1;
        }
        el.onmouseout = function(){
            el.style.backgroundColor = 'rgba(179, 246, 85, 0)';
            el.style.borderColor = '';
            el.style.color = '';
            hint.style.opacity = 0;
        }   
    }
}

function translate() {
    for (var i = 0; i < el_id_counter; i++) {
        let el = document.getElementById(`easy_learner_${i}`);
        translateNode(el);
    }
}

function translateNode(node) {
    var sourceLang = 'auto';
    // if (e.parameter.source) {
    //   sourceLang = e.parameter.source;
    // }
  
    var targetLang = language;
  
    /* Option 1 */
  
    // var translatedText = LanguageApp.translate(sourceText, sourceLang, targetLang);
  
    /* Option 2 */
  
    var url =
      'https://translate.googleapis.com/translate_a/single?client=gtx&sl=' +
      sourceLang +
      '&tl=' +
      targetLang +
      '&dt=t&q=' +
      encodeURI(node.getAttribute("data-translation"));
  
    // var result = JSON.parse(UrlFetchApp.fetch(url).getContentText());
    
    fetch(url).then(function(response) {
        return response.json();
      }).then(function(data) {
        node.textContent = data[0][0][0];
      }).catch(function(err) {
        console.log('Fetch Error :-S', err);
      });

    // translatedText = result[0][0][0];
  
    // return translatedText;
  }