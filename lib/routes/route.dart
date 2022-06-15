const rootRoute = "/";

const homePageDisplayName = "Home";
const homePageRoute = "/home";

const driversPageDisplayName = "Driver";
const driversPageRoute = "/driver";

const clientPageDisplayName = "Client";
const clientPageRoute = "/client";

const authenticationPageDisplayName = "Log Out";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

// clean up later
List<MenuItem> sideMenuItems = [
  MenuItem(homePageDisplayName, homePageRoute),
  MenuItem(driversPageDisplayName, driversPageRoute),
  MenuItem(clientPageDisplayName, driversPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute)
];

const deliveryPageDisplayName = "Deliveries";
const deliveryPageRoute = "/deliveries";

const clientInfoPageDisplayName = "ClientInfo";
const clientInfoPageRoute = "/clientInfo";

const settingsPageDisplayName = "Settings";
const settingsPageRoute = "/Settings";

List<MenuItem> driverMenuItems = [
  MenuItem(deliveryPageDisplayName, deliveryPageRoute),
  MenuItem(clientInfoPageDisplayName, clientInfoPageRoute),
  MenuItem(settingsPageDisplayName, settingsPageRoute),
];
