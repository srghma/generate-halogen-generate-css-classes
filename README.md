# generate-halogen-generate-css-classes

Generate classes

Example

```sh

# from
/nix/store/pshda93lw9mzmjy24ml0ly7cfkz480ka-fd-7.4.0/bin/fd --type f .css /home/srghma/projects/purescript-halogen-nextjs/node_modules/@rmwc

/home/srghma/projects/purescript-halogen-nextjs/node_modules/@rmwc/avatar/avatar.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@rmwc/badge/badge.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@rmwc/circular-progress/circular-progress.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@rmwc/data-table/data-table.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@rmwc/icon/icon.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@rmwc/list/collapsible-list.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@rmwc/select/select.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@rmwc/theme/theme.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@rmwc/tooltip/tooltip.css

# from
/nix/store/pshda93lw9mzmjy24ml0ly7cfkz480ka-fd-7.4.0/bin/fd --type f "mdc\.[\w-]+\.css$" /home/srghma/projects/purescript-halogen-nextjs/node_modules/@material | grep dist

/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/button/dist/mdc.button.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/card/dist/mdc.card.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/checkbox/dist/mdc.checkbox.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/chips/dist/mdc.chips.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/data-table/dist/mdc.data-table.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/dialog/dist/mdc.dialog.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/drawer/dist/mdc.drawer.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/elevation/dist/mdc.elevation.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/fab/dist/mdc.fab.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/floating-label/dist/mdc.floating-label.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/form-field/dist/mdc.form-field.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/grid-list/dist/mdc.grid-list.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/grid-list/node_modules/@material/theme/dist/mdc.theme.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/grid-list/node_modules/@material/typography/dist/mdc.typography.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/icon-button/dist/mdc.icon-button.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/image-list/dist/mdc.image-list.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/layout-grid/dist/mdc.layout-grid.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/line-ripple/dist/mdc.line-ripple.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/linear-progress/dist/mdc.linear-progress.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/list/dist/mdc.list.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/menu/dist/mdc.menu.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/menu-surface/dist/mdc.menu-surface.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/notched-outline/dist/mdc.notched-outline.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/radio/dist/mdc.radio.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/ripple/dist/mdc.ripple.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/select/dist/mdc.select.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/slider/dist/mdc.slider.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/snackbar/dist/mdc.snackbar.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/switch/dist/mdc.switch.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/tab/dist/mdc.tab.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/tab-bar/dist/mdc.tab-bar.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/tab-indicator/dist/mdc.tab-indicator.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/tab-scroller/dist/mdc.tab-scroller.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/textfield/dist/mdc.textfield.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/theme/dist/mdc.theme.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/top-app-bar/dist/mdc.top-app-bar.css
/home/srghma/projects/purescript-halogen-nextjs/node_modules/@material/typography/dist/mdc.typography.css

gen () {
  # e.g. $2 = "Classes.RMWC.Avatar"
  # e.g. filedir = "Classes/RMWC/Avatar.purs"
  filedir=$(echo -n "$2" | sd --string-mode '.' '/' && echo -n ".purs")
  output="/home/srghma/projects/purescript-halogen-nextjs/src/$filedir"
  mkdir -p $(dirname $output)

  /home/srghma/projects/generate-halogen-generate-css-classes/.stack-work/dist/x86_64-linux-nix/Cabal-2.4.0.1/build/generate-halogen-generate-css-classes-exe/generate-halogen-generate-css-classes-exe \
    --input "/home/srghma/projects/purescript-halogen-nextjs/node_modules/$1" \
    --output "$output" \
    --module-name "$2"
}

gen @rmwc/avatar/avatar.css                                Classes.RMWC.Avatar
gen @rmwc/badge/badge.css                                  Classes.RMWC.Badge
gen @rmwc/circular-progress/circular-progress.css          Classes.RMWC.CircularProgress
gen @rmwc/data-table/data-table.css                        Classes.RMWC.DataTable
gen @rmwc/icon/icon.css                                    Classes.RMWC.Icon
gen @rmwc/list/collapsible-list.css                        Classes.RMWC.List
gen @rmwc/select/select.css                                Classes.RMWC.Select
gen @rmwc/theme/theme.css                                  Classes.RMWC.Theme
gen @rmwc/tooltip/tooltip.css                              Classes.RMWC.Tooltip
gen @material/button/dist/mdc.button.css                   Classes.Material.Button
gen @material/card/dist/mdc.card.css                       Classes.Material.Card
gen @material/checkbox/dist/mdc.checkbox.css               Classes.Material.Checkbox
gen @material/chips/dist/mdc.chips.css                     Classes.Material.Chips
gen @material/data-table/dist/mdc.data-table.css           Classes.Material.DataTable
gen @material/dialog/dist/mdc.dialog.css                   Classes.Material.Dialog
gen @material/drawer/dist/mdc.drawer.css                   Classes.Material.Drawer
gen @material/elevation/dist/mdc.elevation.css             Classes.Material.Elevation
gen @material/fab/dist/mdc.fab.css                         Classes.Material.Fab
gen @material/floating-label/dist/mdc.floating-label.css   Classes.Material.FloatingLabel
gen @material/form-field/dist/mdc.form-field.css           Classes.Material.FormField
gen @material/grid-list/dist/mdc.grid-list.css             Classes.Material.GridList
gen @material/icon-button/dist/mdc.icon-button.css         Classes.Material.IconButton
gen @material/image-list/dist/mdc.image-list.css           Classes.Material.ImageList
gen @material/layout-grid/dist/mdc.layout-grid.css         Classes.Material.LayoutGrid
gen @material/line-ripple/dist/mdc.line-ripple.css         Classes.Material.LineRipple
gen @material/linear-progress/dist/mdc.linear-progress.css Classes.Material.LinearProgress
gen @material/list/dist/mdc.list.css                       Classes.Material.List
gen @material/menu/dist/mdc.menu.css                       Classes.Material.Menu
gen @material/menu-surface/dist/mdc.menu-surface.css       Classes.Material.MenuSurface
gen @material/notched-outline/dist/mdc.notched-outline.css Classes.Material.NotchedOutline
gen @material/radio/dist/mdc.radio.css                     Classes.Material.Radio
gen @material/ripple/dist/mdc.ripple.css                   Classes.Material.Ripple
gen @material/select/dist/mdc.select.css                   Classes.Material.Select
gen @material/slider/dist/mdc.slider.css                   Classes.Material.Slider
gen @material/snackbar/dist/mdc.snackbar.css               Classes.Material.Snackbar
gen @material/switch/dist/mdc.switch.css                   Classes.Material.Switch
gen @material/tab/dist/mdc.tab.css                         Classes.Material.Tab
gen @material/tab-bar/dist/mdc.tab-bar.css                 Classes.Material.TabBar
gen @material/tab-indicator/dist/mdc.tab-indicator.css     Classes.Material.TabIndicator
gen @material/tab-scroller/dist/mdc.tab-scroller.css       Classes.Material.TabScroller
gen @material/textfield/dist/mdc.textfield.css             Classes.Material.Textfield
gen @material/theme/dist/mdc.theme.css                     Classes.Material.Theme
gen @material/top-app-bar/dist/mdc.top-app-bar.css         Classes.Material.TopAppBar
gen @material/typography/dist/mdc.typography.css           Classes.Material.Typography
```
