/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
//import Core 1.0

var g_font_pixelSize = 26;

/// http://doc.qt.nokia.com/qt-components-symbian/qml-style.html
var g_color_normal = "#00AAAAAA";
var g_color_bg_normal = "#00000000";
var g_color_bg_pressed = "steelblue";
var g_color_border = "gray"

var g_info = "redak : text editor\n\nURL: http://rzr.online.fr/q/redak\nLicense: GPL-3+\nContact: Phil Coval <rzr@gna.org>\nVersion: 0.3.0\n\n";


function log(text)
{
    if ( !false ) {
        console.log(text);
    }
}


function image(filename)
{
    //    "image://theme/icon-m-common-drilldown-arrow"
    //                                + (theme.inverted ? "-inverse" : "")
    var res = filename; //
    //res += ( platformInverted )  ? "-inverse" : "";
    return res;
}


/// obsolete
function loadUrl(filename)
{
    parent.visible = true;
    textView.text = "loading: " + filename;
    var url = null;
    url =  Qt.resolvedUrl( filename );
    var loader = new XMLHttpRequest();
    loader.open( "GET", url );
    loader.onreadystatechange = function() {
                if (XMLHttpRequest.DONE == loader.readyState ) {
                    textView.text = loader.responseText;
                } }
    loader.send();
}


function handleFolderChanged(path)
{
    //console.log("handleFolderChanged: "+path);
    editPage.folderPath=path;
    //appWindow.folderPath=path;
}


function handlePath(filepath)
{
    var res = true;
    var filename = "unknown.txt"
    var content = editPage.filepath;
    if ( null != filepath ) { filename = filepath; }

    //log("log: io: mode="+ editPage.mode + " path=" +  filename );

    if ( 1 == browserPage.mode ) {
        log("saving:" + filename );
        content = editPage.content;
        res &= core.save( content, filename );
    } else {
        //platformCloseSoftwareInputPanel(); //TODO
        content = core.load( filename );
        editPage.content = content; //todo
    }

    //editPage.listView.focus = true;
    if ( res ) { /*appWindow.*/ pageStack.pop(); }

    return res;
}
