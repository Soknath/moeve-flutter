import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';
import 'package:phone_auth_handler_demo/widgets/popover.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  MaplibreMapController? mapController;
  var isLight = true;

  _onMapCreated(MaplibreMapController controller) {
    mapController = controller;
  }

  _onStyleLoadedCallback() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Style loaded :)'),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 1),
    ));
  }

  void _handleMapClick(point, latLng) {
    debugPrint(
        'Map click: ${point.x},${point.y}   ${latLng.latitude}/${latLng.longitude}');
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Popover(
          child: Column(
            children: [
              _buildListItem(
                context,
                title: Text('Total Task'),
                leading: Icon(Icons.check_circle_outline),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
              _buildListItem(
                context,
                title: const Text('Due Soon'),
                leading: const Icon(Icons.inbox),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              _buildListItem(
                context,
                title: const Text('Completed'),
                leading: const Icon(Icons.check_circle),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              _buildListItem(
                context,
                title: const Text('Working On'),
                leading: const Icon(Icons.flag),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    Widget? title,
    Widget? leading,
    Widget? trailing,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (leading != null) leading,
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text('copied text theme', style: theme.textTheme.button),
            ),
          const Spacer(),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
            // TODO: commented out when cherry-picking https://github.com/flutter-mapbox-gl/maps/pull/775
            // needs different dark and light styles in this repo
            // floatingActionButton: Padding(
            // padding: const EdgeInsets.all(32.0),
            // child: FloatingActionButton(
            // child: Icon(Icons.swap_horiz),
            // onPressed: () => setState(
            // () => isLight = !isLight,
            // ),
            // ),
            // ),

            body: MaplibreMap(
          // TODO: styleString: isLight ? MapboxStyles.LIGHT : MapboxStyles.DARK,
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(target: LatLng(0.0, 0.0)),
          onStyleLoadedCallback: _onStyleLoadedCallback,
          onMapClick: _handleMapClick,
        ))
      ],
    );
  }
}
