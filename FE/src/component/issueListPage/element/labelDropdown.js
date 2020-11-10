import React from "react";
import { hot } from "react-hot-loader";
import Dropdown from "react-dropdown";
import "react-dropdown/style.css";

function LabelDropdown(props) {
  const { labels, setCondition, condition } = props;
  const labelOption = labels.map((label) => {
    return { value: label.name, label: label.name };
  });
  labelOption.unshift({ label: "issue with no label", value: "empty" });
  labelOption.unshift({ label: "label", value: null });
  const onLabelHandler = (event) => {
    setCondition({ label: event.value, milestone: condition.milestone });
  };
  return <Dropdown options={labelOption} value={null} onChange={onLabelHandler} placeholder="label" />;
}

export default hot(module)(LabelDropdown);
