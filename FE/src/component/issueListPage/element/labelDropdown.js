import React from "react";
import { hot } from "react-hot-loader";
import Dropdown from "react-dropdown";
import "react-dropdown/style.css";

function LabelDropdown(props) {
  const { labelOption, setCondition, condition } = props;
  const onLabelHandler = (event) => {
    setCondition({ label: event.value, milestone: condition.milestone });
  };
  return <Dropdown options={labelOption} value={null} onChange={onLabelHandler} placeholder="label" />;
}

export default hot(module)(LabelDropdown);
