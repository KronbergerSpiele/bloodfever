/// <reference path="./bridge.js" />

function log(...args) {
  console.log("JSGDBridge:", ...args);
}

log("Wrapper loaded");
/**@type {JSGDBridge} */
const instance = new JSGDBridge("Johnny");
log("Bridge Instance", instance);
const iframe = document.getElementById("game");
log("Game Frame", iframe);
iframe.contentWindow.jsgdbridge = instance;
log("Instance injected");
