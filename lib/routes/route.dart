const rootRoute = "/";

const homePageDisplayName = "Dashboard";
const homePageRoute = "/home";

const mainPageRoute = "/";

const driversPageDisplayName = "Drivers";
const driversPageRoute = "/driver";

const clientPageDisplayName = "Clients";
const clientPageRoute = "/client";

const authenticationPageDisplayName = "Log Out";
const authenticationPageRoute = "/auth";

const deliveryDisplayName = "Deliveries";
const deliveryPageRoute = "/Deliveries";

const analyticsDisplayName = "Analtyics";
const analyticsPageRoute = "/anlytics";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

// clean up later
List<MenuItem> sideMenuItems = [
  MenuItem(homePageDisplayName, homePageRoute),
  MenuItem(deliveryDisplayName, deliveryPageRoute),
  MenuItem(driversPageDisplayName, driversPageRoute),
  MenuItem(clientPageDisplayName, driversPageRoute),
  MenuItem(analyticsDisplayName, analyticsPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];

const deliveryPageDisplayName = "Deliveries";
//const deliveryPageRoute = "/deliveries";

const clientInfoPageDisplayName = "ClientInfo";
const clientInfoPageRoute = "/clientInfo";

const settingsPageDisplayName = "Settings";
const settingsPageRoute = "/Settings";

List<MenuItem> driverMenuItems = [
  MenuItem(deliveryPageDisplayName, deliveryPageRoute),
  MenuItem(clientInfoPageDisplayName, clientInfoPageRoute),
  MenuItem(settingsPageDisplayName, settingsPageRoute),
];
