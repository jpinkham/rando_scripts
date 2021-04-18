//iOS Scriptable script
// Displays current public IP
//
ip_url = "https://whatismyip.host/ipv4";

let req = new Request(ip_url)
let json = await req.loadJSON()
let widget = createWidget("IP", json.ipv4)
if (config.runsInWidget) {
    // create and show widget
    Script.setWidget(widget)
    Script.complete()
}
else {
    widget.presentSmall()
}

function createWidget(title, ipaddress) {
    let w = new ListWidget()
    w.backgroundColor = new Color("#1A1A1A")
    w.addText("External IP:").centerAlignText()
    let titleTxt = w.addText(ipaddress)
    titleTxt.textColor = Color.white()
    titleTxt.font = Font.mediumMonospacedSystemFont(16)
    titleTxt.centerAlignText()
    w.setPadding(0, 5, 0, 0)
    return w
}
