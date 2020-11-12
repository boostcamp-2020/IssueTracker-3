import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Select, MenuItem } from "@material-ui/core";

const Styled = styled.div`
  margin-right: 20px;
`;

function MilestoneDropdown(props) {
  const { milestones, setCondition, condition } = props;
  const milestoneOption = milestones.map((milestone) => {
    return { value: milestone.name, label: milestone.name };
  });
  milestoneOption.unshift({ label: "issue with no milestone", value: "empty" });
  milestoneOption.unshift({ label: "milestone", value: "default" });
  const onMilestoneHandler = (event) => {
    setCondition({ label: condition.label, milestone: event.target.value, user: condition.user });
  };
  return (
    <Styled>
      <Select defaultValue="default" onChange={onMilestoneHandler}>
        {milestoneOption.map((milestone) => {
          return <MenuItem value={milestone.value}>{milestone.label}</MenuItem>;
        })}
      </Select>
    </Styled>
  );
}

export default hot(module)(MilestoneDropdown);
