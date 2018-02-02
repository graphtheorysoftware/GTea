$ ->
    document.addEventListener 'ping', (e) -> addMyUUIDToStorage

    document.addEventListener 'newGraph', (e) ->
        alert e.detail

    $(document).on "click", "#do_products", ->
        alert allOpenGraphs()





#keeping track of all open graphs in all tabs
$ ->
    $(window).bind 'storage', (event) ->
        if (event.key == 'requestOpenGraphs')
            addMyUUIDToStorage()

allOpenGraphs = () ->
    localStorage.setObject 'allOpenGraphs', {}

    # need a change in the localStorage so the event triggers in all windows
    localStorage.setItem 'requestOpenGraphs', 0
    localStorage.setItem 'requestOpenGraphs', 1

    #and also add the curent tab's graph
    addMyUUIDToStorage()

    # the event propagates all around and then...
    localStorage.getObject 'allOpenGraphs'


addMyUUIDToStorage = ()->
    all = localStorage.getObject 'allOpenGraphs'
    all[uuid] = 1
    localStorage.setObject 'allOpenGraphs', all


Storage.prototype.setObject = (key, value) -> this.setItem(key, JSON.stringify(value))

Storage.prototype.getObject = (key) ->
    value = this.getItem(key)
    value && JSON.parse(this.getItem(key))
