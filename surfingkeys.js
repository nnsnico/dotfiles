const {
    aceVimMap,
    mapkey,
    imap,
    imapkey,
    iunmap,
    getClickableElements,
    vmapkey,
    map,
    unmap,
    unmapAllExcept,
    vunmap,
    cmap,
    addSearchAlias,
    removeSearchAlias,
    tabOpenLink,
    readText,
    Clipboard,
    Front,
    Hints,
    Visual,
    RUNTIME
} = api;

// ------------------------------ general settings -----------------------------

// disable emoji completion
iunmap(":");
settings.omnibarPosition = "middle";

// ----------------------------------- keymap ----------------------------------

// 1.0.0へのアップデートにより正しく機能しなくなったのでとりあえず爆発しないようにunmapする
settings.autoSpeakOnInlineQuery	= false;
Front.registerInlineQuery({
    url: 'https://script.google.com/macros/s/AKfycbxOcWmQkWRNeazgcTHxizUkPhEYi9HjG5qJ5zV7PWs0drOcIo0/exec?source=en&target=ja&text=',
    parseResult: function(res) {
        try {
            // remove double quate
            const result = res.text.replace(/[\"]/g,"");
            return `<div>${result}</div>`;
        } catch (e) {
            return "";
        }
    }
});
// api.vunmap('q');

// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
map('gt', 'T');

iunmap("<Ctrl-f>")
iunmap("<Ctrl-e>")

unmap('ZZ')
cmap("<Ctrl-j>", '')

mapkey('yY', "#7Copy the current page's decoded URL ", function() {
    const url = window.location.href;
    Clipboard.write(decodeURI(url));
});

mapkey('yb', '#8Copy the current page with markdown link', function() {
    const url = window.location.href;
    const title = window.document.title;
    const formatstring = `[${title}](${url})`
    Clipboard.write(formatstring)
})

// override to japanese
addSearchAlias('e', 'wikipedia', 'https://ja.wikipedia.org/wiki/', 's', 'https://ja.wikipedia.org/w/api.php?action=opensearch&format=json&formatversion=2&namespace=0&limit=40&search=', function(response) {
    return JSON.parse(response.text)[1];
});

mapkey(';G', "#1Go to google", function() {
    RUNTIME('openLink', { url: 'https://www.google.com/', tab: { tabbed: false } });
});

mapkey(';g', "#1Go to google in new tab", function() {
    RUNTIME('openLink', { url: 'https://www.google.com/', tab: { tabbed: true } });
});

// ----------------------------------- theme -----------------------------------

// Spacemacs theme
settings.theme = `
.sk_theme {
	background: #100a14dd;
	color: #4f97d7;
}
.sk_theme tbody {
	color: #292d;
}
.sk_theme input {
	color: #d9dce0;
}
.sk_theme .url {
	color: #2d9574;
}
.sk_theme .annotation {
	color: #a31db1;
}
.sk_theme .omnibar_highlight {
	color: #333;
	background: #ffff00aa;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
	background: #5d4d7a55;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
	background: #5d4d7aaa;
}
.sk_theme #sk_omnibarSearchResult .omnibar_folder {
	color: #a31db1;
}
`;

Hints.style('font-size: 11pt; border: solid 2px #C38A22; color:#fcfcfc; background: #de691b; background-color: #de691b;');
Hints.style("font-size: 11pt; border: solid 2px #C38A22; color:#fcfcfc; background: #de691b; background-color: #de691b;", "text");

// disable keymaps partially for some sites
api.unmap('t', /github\.com\/.*blob.*/);
api.unmap('/', /github\.com\/.*blob.*/);
