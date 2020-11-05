import React from "react";
import ReactDom from "react-dom";
import Header from "./component/header/header";
import App from "./app";

ReactDom.render(
  <div>
    <Header></Header>
    {/* <Content></Content> */}
    <App></App>
  </div>,
  document.getElementById("root")
);
