xquery version "3.1";
declare namespace functx = "http://www.functx.com";
import module namespace xmldb="http://exist-db.org/xquery/xmldb";
import module namespace config="http://www.digital-archiv.at/ns/aratea-app/config" at "../modules/config.xqm";
import module namespace app="http://www.digital-archiv.at/ns/aratea-app/templates" at "../modules/app.xql";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace util = "http://exist-db.org/xquery/util";
declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=no indent=yes";

let $baseID := 'https://id.acdh.oeaw.ac.at/'
let $RDF := 
<rdf:RDF
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:acdh="https://vocabs.acdh.oeaw.ac.at/#"
    xmlns:acdhi="https://id.acdh.oeaw.ac.at/"
    xmlns:foaf="http://xmlns.com/foaf/spec/#"

    xml:base="https://id.acdh.oeaw.ac.at/">
    
<!-- define involved Persons -->
    
        <acdh:Person rdf:about="https://orcid.org/0000-0003-2388-1114">
            <acdh:hasTitle>Ivana Dobcheva</acdh:hasTitle>
            <acdh:hasLastName>Ivana</acdh:hasLastName>
            <acdh:hasFirstName>Dobcheva</acdh:hasFirstName>
        </acdh:Person>  
        <acdh:Person rdf:about="https://orcid.org/0000-0003-2388-1114">
            <acdh:hasTitle>Peter Andorfer</acdh:hasTitle>
            <acdh:hasLastName>Andorfer</acdh:hasLastName>
            <acdh:hasFirstName>Peter</acdh:hasFirstName>
        </acdh:Person>
        
<!-- define involved Organisations
        
       <acdh:Organisation rdf:about="http://d-nb.info/gnd/108889819X">
            <acdh:hasTitle>Fonds zur Förderung der Wissenschaftlichen Forschung (Österreich)</acdh:hasTitle>
        </acdh:Organisation> -->
        
<!-- define involved Project(s) -->        

        <acdh:Project rdf:about="https://id.acdh.oeaw.ac.at/project/aratea-digital">
            <acdh:hasTitle>The Aratea in the Latin Middle Ages</acdh:hasTitle>
            <acdh:hasDescription>
            The aim of this project website is to provide basic information on the latin translations and derivative texts based on Aratus' didactic poem Phaenomena. Apart from references to the latest editions and relevant literature, the focus of the project is to list all pre-13th-century manuscripts of the texts and provide them with descriptions. 
            This website is work-in-progress. We are constantly working on improving and enhancing the information provided.
            </acdh:hasDescription>
            <acdh:hasStartDate>2010-07-01</acdh:hasStartDate>
            <acdh:hasEndDate>2018-06-30</acdh:hasEndDate>
            <acdh:hasPrincipalInvestigator>
                <acdh:Person rdf:about="https://orcid.org/0000-0003-2388-1114"/>
            </acdh:hasPrincipalInvestigator>
        </acdh:Project>
        

        <acdh:Collection rdf:about="{concat($baseID, $config:app-name)}">
            <acdh:hasTitle>{$config:app-title}</acdh:hasTitle>
            <acdh:hasDescription>{$config:repo-description/text()}</acdh:hasDescription>
            <acdh:hasRelatedProject>
                <acdh:Project rdf:about="https://id.acdh.oeaw.ac.at/project/aratea-digital"/>
            </acdh:hasRelatedProject>
            <acdh:hasContributor>
                <acdh:Person rdf:about="https://orcid.org/0000-0003-2388-1114"/>
            </acdh:hasContributor>
            
        </acdh:Collection>
        <acdh:Collection rdf:about="{concat($baseID, string-join(($config:app-name, 'data'), '/'))}">
            <acdh:hasTitle>{string-join(($config:app-name, 'data'), '/')}</acdh:hasTitle>
            <acdh:isPartOf rdf:resource="{concat($baseID,$config:app-name)}"/>
            <acdh:hasCreator>
                <acdh:Person rdf:about="https://orcid.org/0000-0003-2388-1114"/>
            </acdh:hasCreator>
        </acdh:Collection>

        {
            for $x in xmldb:get-child-collections($config:data-root) 
                return
                    <acdh:Collection rdf:about="{concat($baseID,string-join(($config:app-name, 'data', $x), '/'))}">
                        <acdh:hasTitle>{string-join(($config:app-name, 'data', $x), '/')}</acdh:hasTitle>
                        <acdh:isPartOf rdf:resource="{concat($baseID, string-join(($config:app-name, 'data'), '/'))}"/>
                    </acdh:Collection>
        }
        {
            for $x in xmldb:get-child-collections($config:data-root)
                for $doc in xmldb:get-child-resources($config:data-root||'/'||$x)
                let $node := try {
                        doc(string-join(($config:data-root, $x, $doc), '/'))
                    } catch * {
                        false()
                    }
                let $filename := string-join(($config:app-name, 'data', $x, $doc), '/')
                let $title := try {
                        <acdh:hasTitle>{normalize-space(string-join($node//tei:titleStmt/tei:title//text(), ' '))}</acdh:hasTitle>
                    } catch * {
                        <acdh:hasTitle>{tokenize($filename, '/')[last()]}</acdh:hasTitle>
                    }
                let $authors := <acdh:hasCreator>
                                    <acdh:Person rdf:about="https://orcid.org/0000-0003-2388-1114"/>
                                </acdh:hasCreator>
                            
                
                let $filename := string-join(($config:app-name, 'data', $x, $doc), '/')
                return
                    <acdh:Resource rdf:about="{concat($baseID, $filename)}">
                        {$title}
                        {$authors}
                        <acdh:isPartOf rdf:resource="{concat($baseID, (string-join(($config:app-name, 'data', $x), '/')))}"/>
                        
                    </acdh:Resource>
        }

        
    </rdf:RDF>
    
return
    $RDF