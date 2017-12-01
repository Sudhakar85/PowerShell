SetEnvironment "Prod"
function SetEnvironment($environment) {

    $configPath = "Web.Config"
    $doc = [System.Xml.XmlDocument](Get-Content $configPath);
    $nodeAlreadyExists = $doc.SelectSingleNode("//environmentVariable[@name='ASPNETCORE_ENVIRONMENT']")
    
    if(!$nodeAlreadyExists)
    {
        $aspNetCoreNode = $doc.SelectSingleNode("//aspNetCore")
    
        $envieonmentVariables = $doc.CreateElement("environmentVariables")
        $envieonmentVariable = $doc.CreateElement("environmentVariable")
        $envieonmentVariable.SetAttribute("name", "ASPNETCORE_ENVIRONMENT")
        $envieonmentVariable.SetAttribute("value", $environment)
    
        $envieonmentVariables.AppendChild($envieonmentVariable)
        $aspNetCoreNode.AppendChild($envieonmentVariables)   
    }
    else {
        $nodeAlreadyExists.SetAttribute("value", $environment)  
    }
    
    $doc.Save($configPath)
}
