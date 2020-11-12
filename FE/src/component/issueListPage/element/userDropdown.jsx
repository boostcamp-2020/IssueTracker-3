import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Select, MenuItem } from "@material-ui/core";

const Styled = styled.div`
  margin-right: 20px;
`;

function UserDropdown(props) {
  const { users, setCondition, condition } = props;
  const userOption = users.map((user) => {
    return { value: user.id, label: user.login_id };
  });
  userOption.unshift({ label: "user", value: "default" });
  const onUserHandler = (event) => {
    setCondition({ label: condition.label, milestone: condition.milestone, user: event.target.value });
  };
  return (
    <Styled>
      <Select defaultValue="default" onChange={onUserHandler}>
        {userOption.map((user) => {
          return <MenuItem value={user.value}>{user.label}</MenuItem>;
        })}
      </Select>
    </Styled>
  );
}

export default hot(module)(UserDropdown);
