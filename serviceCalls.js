function login(username, password) {
    var tokenResponse = ""
    var data = JSON.stringify({
      "identifier": username,
      "password": password
    });

    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            try {
                tokenResponse = JSON.parse(xhr.responseText);
            }
            catch (err) {
                tokenResponse = {
                    message: "Something went wrong, could not log in."
                }
            }

        }
    }

    xhr.open("POST", "http://devel.uniqcast.com:3001/auth/local", false);
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.send(data);
    return tokenResponse;
}

function fetchChannels(token) {
    var channels = "";
    var data = "";

    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            try {
                channels = JSON.parse(xhr.responseText);
            }
            catch (err) {
                channels = {
                    message: "Something went wrong, could not load the channels."
                }
            }
        }
    }

    xhr.open("GET", "http://devel.uniqcast.com:3001/channels", false);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.setRequestHeader("Authorization", "Bearer " + token);

    xhr.send(data);

    return channels;
}
