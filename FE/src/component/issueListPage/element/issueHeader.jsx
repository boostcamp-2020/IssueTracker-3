import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import MoveToCreateIssueButton from "@component/issueListPage/buttons/moveToCreateIssueButton";
import MoveToLabelButton from "@component/labelListPage/buttons/moveToLabelButton";
import MoveToMilestoneButton from "@component/labelListPage/buttons/moveToMilestoneButton";
import { Select, MenuItem } from "@material-ui/core";

const Styled = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
  margin-bottom: 20px;
  width: 100%;
  .item {
    flex: none;
  }
  .right-item {
    margin-left: auto;
    display: flex;
  }
`;

function IsssueHeader(props) {
  const { labels, milestones, condition, setCondition, user } = props;
  const onConditionHandler = (event) => {
    switch (event.target.value) {
      case "default":
        setCondition({ state: 1, author: null, assignee: null, comment: null });
        break;
      case "open":
        setCondition({ state: 1, author: condition.author, assignee: condition.assignee, comment: condition.comment });
        break;
      case "close":
        setCondition({ state: 0, author: condition.author, assignee: condition.assignee, comment: condition.comment });
        break;
      case "author":
        setCondition({ state: condition.state, author: user.id, assignee: condition.assignee, comment: condition.comment });
        break;
      case "assignee":
        setCondition({ state: condition.state, author: condition.author, assignee: user.id, comment: condition.comment });
        break;
      case "comment":
        setCondition({ state: condition.state, author: condition.author, assignee: condition.assignee, comment: user.id });
        break;
      default:
        break;
    }
  };
  return (
    <>
      <Styled>
        <Select className="item" defaultValue="default" onChange={onConditionHandler}>
          <MenuItem value="default">Filters</MenuItem>
          <MenuItem value="open">Open issues</MenuItem>
          <MenuItem value="close">Close issues</MenuItem>
          <MenuItem value="author">Your issues</MenuItem>
          <MenuItem value="assignee">Everything assigned to you</MenuItem>
          <MenuItem value="comment">Everything mentioning to you</MenuItem>
        </Select>
        <div className="item right-item">
          <MoveToLabelButton labels={labels} />
          <MoveToMilestoneButton milestones={milestones} />
          <MoveToCreateIssueButton />
        </div>
      </Styled>
    </>
  );
}

export default hot(module)(IsssueHeader);
