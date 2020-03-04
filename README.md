# defaultbrowser

A command line utility to change the default browser in macOS.

## Installation
To build and install the application, type in your terminal:

```bash
make install
```

Or if you just want to build the application:

```bash
make
```

## Usage
To print a list of available browsers and other http handlers:

```bash
defaultbrowser [-cv]
```

To change the default browser:

```bash
defaultbrowser <BROWSER>
```

To print a list of all available options:

```bash
defaultbrowser --help
```

### Alfred Compatibility
defaultbrowser can print results in the [Alfred] compatible [Script Filter] 
format by typing:

```bash
defaultbrowser --alfred
```

but check [defaultbrowser-alfred-workflow] if you need an [Alfred] workflow 
to change your default browser.

## License
[MIT]

[Alfred]: http://alfredapp.com
[Script Filter]: https://www.alfredapp.com/help/workflows/inputs/script-filter/json/
[defaultbrowser-alfred-workflow]: https://github.com/erremauro/defaultbrowser-alfred-workflow
[MIT]: https://github.com/erremauro/blob/master/LICENSE
