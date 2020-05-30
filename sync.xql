xquery version "3.1";

declare namespace expath="http://expath.org/ns/pkg";
declare namespace repo="http://exist-db.org/xquery/repo";

import module namespace config="http://www.digital-archiv.at/ns/config" at "modules/config.xqm";

let $target-dir := "C:\Users\ivana\Documents\aratea-digital\aratea-app"
return

<response>{
try{
    let $source := request:get-parameter("source",$config:app-root)
    let $synced-files :=  file:sync($source, $target-dir, ())
    return $synced-files

} catch * {
    let $log := util:log("ERROR", ($err:code, $err:description) )
    return <ERROR>{($err:code, $err:description)}</ERROR>
}
}</response>
