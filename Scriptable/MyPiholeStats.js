//iOS Scriptable script
// Displays current pihole stats
//

let pihole_host = "192.168.2.5"

let pistats_url = "http://" + pihole_host + "/admin/api.php?summary";

let req = new Request(pistats_url)
let json = await req.loadJSON()
let widget = createWidget("Stats", json)
if (config.runsInWidget) {
    // create and show widget
    Script.setWidget(widget)
    Script.complete()
}
else {
    widget.presentSmall()
}
function createWidget(title, json) {
    let w = new ListWidget()
    //w.backgroundColor = new  Color("#005500")   //green

// if (json.status != "enabled"){
// w.backgroundColor = new Color("#FF1100")
// }

w.addText("Status: ").font = Font.blackMonospacedSystemFont(12)
if (json.status == "enabled"){     
w.addText(json.status).textColor = Color.green()
} else {
    w.addText(json.status).textColor = Color.red()
}


let all_the_text = "\nQueries today: " + json.dns_queries_today
all_the_text += "\n# Ads blocked: " + json.ads_blocked_today
all_the_text += "\n% Ads blocked: " + json.ads_percentage_today
all_the_text += "\nUniq domains: " + json.unique_domains
all_the_text += "\nGravityDB age: " + json.gravity_last_updated.relative.days + "d, " + json.gravity_last_updated.relative.hours + "h"



	let widget_text = w.addText(all_the_text)
    widget_text.textColor = Color.white()
    widget_text.font = Font.mediumMonospacedSystemFont(12)
    widget_text.leftAlignText()

    w.setPadding(0, 5, 0, 0)
    return w
}

