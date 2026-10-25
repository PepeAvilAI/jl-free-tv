sub init()
    m.top.backgroundColor = "0x101827FF"
    m.list = m.top.findNode("channels")
    m.video = m.top.findNode("player")
    m.status = m.top.findNode("status")
    m.timer = m.top.findNode("loadTimer")
    m.entries = []
    setEntries(ParseJson(ReadAsciiFile("pkg:/data/channels.json")), "lista guardada")
    m.listTask = CreateObject("roSGNode", "ListTask")
    m.listTask.url = "https://raw.githubusercontent.com/PepeAvilAI/jl-free-tv/main/channels.json"
    m.listTask.observeField("result", "remoteListLoaded")
    m.listTask.control = "run"
    m.list.observeField("itemSelected", "playSelected")
    m.video.observeField("state", "videoStateChanged")
    m.timer.observeField("fire", "loadTimedOut")
    m.list.SetFocus(true)
end sub

sub setEntries(entries as dynamic, source as string)
    if type(entries) <> "roArray" then return
    valid = []
    for each entry in entries
        if type(entry) = "roAssociativeArray" and isText(entry.name) and isText(entry.url)
            if not isText(entry.group) then entry.group = "Otros"
            valid.Push(entry)
        end if
    end for
    if valid.Count() = 0 then return
    m.entries = valid
    content = CreateObject("roSGNode", "ContentNode")
    for each entry in m.entries
        item = content.CreateChild("ContentNode")
        item.title = entry.group + "  |  " + entry.name
    end for
    m.list.content = content
    m.top.findNode("heading").text = "JL Free TV - " + m.entries.Count().ToStr() + " canales (" + source + ")"
end sub

function isText(value as dynamic) as boolean
    return GetInterface(value, "ifString") <> invalid
end function

sub remoteListLoaded()
    body = m.listTask.result
    if body = "" then
        print "JLTV remote list: sin respuesta, se queda la lista guardada"
        return
    end if
    setEntries(ParseJson(body), "GitHub")
    print "JLTV remote list: "; m.entries.Count(); " canales"
end sub

sub playSelected()
    index = m.list.itemSelected
    if index < 0 or index >= m.entries.Count() then return
    entry = m.entries[index]
    videoContent = CreateObject("roSGNode", "ContentNode")
    videoContent.title = entry.name
    videoContent.url = entry.url
    videoContent.streamFormat = "hls"
    videoContent.live = true
    m.video.content = videoContent
    m.video.visible = true
    m.video.SetFocus(true)
    m.video.control = "play"
    m.timer.control = "start"
    print "JLTV selected: "; entry.name
end sub

sub videoStateChanged()
    state = m.video.state
    print "JLTV video state: "; state
    if state = "playing"
        m.timer.control = "stop"
    else if state = "error"
        print "JLTV error: "; m.video.errorCode; " "; m.video.errorMsg
        showList("Este canal no se pudo reproducir. Prueba otro o reintenta mas tarde.")
    else if state = "finished"
        showList("La emision termino. Selecciona otro canal.")
    end if
end sub

sub loadTimedOut()
    if m.video.state <> "playing"
        showList("El canal tarda en cargar. Prueba otro o reintenta mas tarde.")
    end if
end sub

sub showList(message as string)
    m.timer.control = "stop"
    m.video.control = "stop"
    m.video.visible = false
    m.status.text = message
    m.list.SetFocus(true)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press and key = "back" and m.video.visible
        showList("Selecciona un canal. OK: reproducir. Atras: volver a la lista.")
        return true
    end if
    return false
end function
