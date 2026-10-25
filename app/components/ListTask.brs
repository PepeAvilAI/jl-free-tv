sub init()
    m.top.functionName = "fetchList"
end sub

sub fetchList()
    transfer = CreateObject("roUrlTransfer")
    transfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    transfer.InitClientCertificates()
    transfer.SetUrl(m.top.url)
    transfer.EnableEncodings(true)
    port = CreateObject("roMessagePort")
    transfer.SetMessagePort(port)
    body = ""
    if transfer.AsyncGetToString()
        msg = wait(15000, port)
        if type(msg) = "roUrlEvent" and msg.GetResponseCode() = 200
            body = msg.GetString()
        else
            transfer.AsyncCancel()
        end if
    end if
    m.top.result = body
end sub
