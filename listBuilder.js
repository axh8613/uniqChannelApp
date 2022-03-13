function loadChannels(lm, res) {
    for(let i = 0; i < res.length; i++){
        if(res[i].name !== undefined)
        {
            lm.append({
                name: res[i].name,
                image: "https://devel.uniqcast.com/samples/logos/"+res[i].id+".png",
                itemUrl: extractMediaPlaylist(res[i].url)
            });
        }
    }
}

function  extractMediaPlaylist(masterUrl) {
    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;
    var res = ""
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            try {
                var lines = xhr.responseText.split('\n');
                   for(var line = 0; line < lines.length; line++){
                       if (lines[line].includes("RESOLUTION")) {
                           res = lines[line + 1]
                           break
                       }
                   }
            }
            catch (err) {
               console.log(err)
            }
        }
    }

    xhr.open("GET", masterUrl, false);

    xhr.send(data);

    return res;
}
