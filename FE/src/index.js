import React from "react";
import ReactDom from "react-dom";
import Header from "./layout/header";
import Content from "./layout/content";

ReactDom.render(
  <div>
    <Header></Header>
    <Content></Content>
  </div>,
  document.getElementById("root")
);
