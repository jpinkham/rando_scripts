//iOS Scriptable script
// Displays current public IP
//
const ip_url = "https://whatismyip.host/ipv4"

try {
    writeLOG('Fetching url: ${ip_url}');
    const request = new Request(ip_url);
    response = request.loadJSON();
 } catch (error) {
      writeLOG('Couldn\'t fetch ${ip_url}');
 }
 try {
    if (response.code != 200) {
      writeLOG('Something went wrong. Received non-200 response code');
      return;
    }
  } catch(error) {
    writeLOG("JSON Data: " + JSON.stringify(response));
  }

return response.ipv4
