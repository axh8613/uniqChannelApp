function loadChannels(lm, res) {
    for(let i = 0; i < res.length; i++){
        if(res[i].name !== undefined)
        {
            lm.append({
                name: res[i].name,
                image: "https://devel.uniqcast.com/samples/logos/"+res[i].id+".png",
                itemUrl: res[i].url
            });
        }
    }
}
