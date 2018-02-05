$ ->
    $(document).on "click", "#do_products", ->
        alert 'uhum'


#keeping track of all open graphs in all windows
$ ->
    #Readable Unique ID
    window.ruid = "G" + (Number(localStorage.getItem('lastRUID') || 0) + 1)
    $('#RUID').html window.ruid
    localStorage.setItem 'lastRUID', window.ruid
    console.log window.ruid

    #keep a list of open windows
    #1- when window opens
    all = localStorage.getObject 'allOpenGraphs'
    all[window.ruid] = uuid
    localStorage.setObject 'allOpenGraphs', all

    #2- when closing the window
    window.onbeforeunload = () ->
        # closing the last window set it to 0
        all = localStorage.getObject 'allOpenGraphs'
        delete all[window.ruid]
        localStorage.setObject 'allOpenGraphs', all

        #reset to zero when we close the last window
        if (Object.keys(localStorage.getObject('allOpenGraphs')).length == 0)
            localStorage.setItem 'lastRUID', 0


Storage.prototype.setObject = (key, value) -> this.setItem(key, JSON.stringify(value))

Storage.prototype.getObject = (key) ->
    value = this.getItem(key)
    value && JSON.parse(this.getItem(key))
