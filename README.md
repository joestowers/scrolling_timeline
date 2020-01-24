# Scrolling Timeline

A vertical scrolling timeline to display Buoy events in a delightful way!

# Slivers

````dart
const SilverGrid({
    @required SliverChildDelegate delegate,
    @required SliverGridDelegate gridDelegate
})

````

## [SliverChildDelegate](https://api.flutter.dev/flutter/widgets/SliverChildDelegate-class.html)

• A delegate that supplies children for slivers.


## [SliverGrid.count](https://api.flutter.dev/flutter/widgets/SliverGrid/SliverGrid.count.html)

• A sliver that places mulitple box children in a 2D arrangment with a fixed number of tiles in the cross axis.

## [SliverGrid.extent](https://api.flutter.dev/flutter/widgets/SliverGrid/SliverGrid.extent.html)

• A sliver that places multiple box children in a 2D arrangement with tiles that each have a maximum cross-axis extent.

• The property `maxCrossAxisExtent` sets the maximum width of each tile

````dart
SliverGrid.extent(
    maxCrossAxisExtent: maxCrossAxisExtent,
    children: <Widget>[
        ColorContainer(
            color: Colors.red, title: 'Container 1 $maxCrossAxisExtent'),
        ColorContainer(
            color: Colors.purple,
            title: 'Container 2 $maxCrossAxisExtent'),
        ColorContainer(
            color: Colors.green,
            title: 'Container 3 $maxCrossAxisExtent'),
        ColorContainer(
            color: Colors.orange,
            title: 'Container 4 $maxCrossAxisExtent'),
    ],
)
````

