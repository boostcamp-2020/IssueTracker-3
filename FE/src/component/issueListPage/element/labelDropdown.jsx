import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Select, MenuItem } from "@material-ui/core";

const Styled = styled.div`
  margin-right: 20px;
`;
function LabelDropdown(props) {
  const { labels, setCondition, condition } = props;
  const labelOption = labels.map((label) => {
    return { value: label.name, label: label.name };
  });
  labelOption.unshift({ label: "issue with no label", value: "empty" });
  labelOption.unshift({ label: "label", value: "default" });
  const onLabelHandler = (event) => {
    setCondition({ label: event.target.value, milestone: condition.milestone, user: condition.user });
  };
  return (
    <Styled>
      <Select defaultValue="default" onChange={onLabelHandler}>
        {labelOption.map((label) => {
          return <MenuItem value={label.value}>{label.label}</MenuItem>;
        })}
      </Select>
    </Styled>
  );
}

export default hot(module)(LabelDropdown);
