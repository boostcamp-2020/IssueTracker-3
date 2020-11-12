import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Checkbox } from "@material-ui/core";

const StyledIssue = styled.div`
  border: 1px solid gray;
  border-radius: 1px;
`;

const Issue = (props) => {
  const { issue, checked, setChecked } = props;
  const onCheckboxHandler = (event) => {
    if (event.target.checked) {
      setChecked([...checked, issue.id]);
    } else {
      const checkout = [...checked];
      const idx = checkout.indexOf(issue.id);
      checkout.splice(idx, 1);
      setChecked(checkout);
    }
  };
  return (
    <>
      <StyledIssue>
        <Checkbox onChange={onCheckboxHandler} />
        <span>{issue.title}</span>
      </StyledIssue>
    </>
  );
};

export default hot(module)(Issue);
