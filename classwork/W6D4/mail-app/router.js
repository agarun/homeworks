class Router {
  constructor(node, routes) {
    this.node = node;
    this.routes = routes;
  }
  
  start() {
    this.render();
    window.addEventListener("hashchange", this.render.bind(this));
  }
  
  activeRoute() {
    const currentHash = window.location.hash.slice(1);
    return this.routes[currentHash];
  }
  
  render() {
    const component = this.activeRoute();
    this.node.innerHTML = "";
    if (component) {
      const routeNameNode = document.createTextNode(component);
      const newNode = component.render();
      this.node.appendChild(newNode);
    }
  }
}

module.exports = Router;