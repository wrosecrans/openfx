#include <iostream>
#include <functional>

#include <boost/dll.hpp>

#include "ofxCore.h"
#include "ofxProperty.h"
#include "ofxMultiThread.h"
#include "ofxMemory.h"
#include "ofxhHost.h"


using std::string;
using std::cout;  using std::endl;

using boost::dll::shared_library;
using boost::dll::library_info;

bool has(library_info &info, string symbol) {
    for (auto &s : info.symbols()) {
        if (symbol == s) {
            return true;
        }
    }
    return false;
}

bool report_on_plugin(string plugin_path) {
    using get_num = int (void);
    using get_plugin = OfxPlugin*(int);

    bool is_native = true;
    cout << "Inspecting " << plugin_path << endl;
    library_info info(plugin_path, false);

    cout << info.symbols().size() << " symbols total." << endl;

    try {
        library_info native_check(plugin_path, true);
    }
    catch (std::runtime_error e)
    {
        is_native = false;
        if (has(info, "OfxGetNumberOfPlugins") && has(info, "OfxGetPlugin")) {
            cout << plugin_path << " is not native to this host.\n"
                 << "But, it does have the required symbols.  " << endl;

        }
        return false;
    }

    shared_library library(plugin_path);

    if (! library.has("OfxGetNumberOfPlugins")) {
        return false;
    }
    if (! library.has("OfxGetPlugin")) {
        return false;
    }
    std::function<get_num> get_num_f = library.get<get_num>("OfxGetNumberOfPlugins");
    std::function<get_plugin> get_plugin_f = library.get<get_plugin>("OfxGetPlugin");

    cout << get_num_f() << " OFX plugins found." << endl;
    for (int i=0; i<get_num_f() ; i++) {
        auto plugin = get_plugin_f(i);
        cout << i << ": " << plugin->pluginIdentifier << endl;
    }

    return true;
}



int main(void) {
    auto sample = string("/home/will/Documents/dev/github-wrosecrans/openfx-misc/build/Misc.ofx");
    report_on_plugin(sample);
    return 0;
}
