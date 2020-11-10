import React from "react";
import { hot } from "react-hot-loader";
import Dropdown from "react-dropdown";
import "react-dropdown/style.css";

function MilestoneDropdown(props) {
  const { milestones, setCondition, condition } = props;
  const milestoneOption = milestones.map((milestone) => {
    return { value: milestone.name, label: milestone.name };
  });
  milestoneOption.unshift({ label: "issue with no milestone", value: null });
  const onMilestoneHandler = (event) => {
    setCondition({ label: condition.label, milestone: event.value });
  };
  return <Dropdown options={milestoneOption} value={null} onChange={onMilestoneHandler} placeholder="milestone" />;
}

export default hot(module)(MilestoneDropdown);
