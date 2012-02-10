var g_font_pixelSize = 30;
var g_color_normal = "#00AAAAAA";
var g_color_bg_normal = "#00000000";
var g_color_bg_pressed = "steelblue";

function save(content, filename)
{
    var content = "content";
    var filename = "filename";

    filename = currentFileNameView.text;

    //content = mainPage.textView.text; //TODO
    //core.save(content,filename);

    core.save( mainPage.content , currentFileNameView.text);

}


function load( filename_arg )
{
    //console.log("log: filename: " + filename);
    filename = filename_arg;

    //mainPage.load( filename );//TODO
    mainPage.content = core.load( filename );
    //console.log("log: content: " + mainPage.content.length );

    appWindow.pageStack.pop();
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
