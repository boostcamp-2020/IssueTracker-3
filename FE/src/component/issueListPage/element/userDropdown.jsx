import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import ModalDropdown from "react-dropdown";

const Styled = styled.div`
  margin-right: 20px;
`;

function UserDropdown(props) {
  const { users, setCondition, condition } = props;
  const userOption = users.map((user) => {
    return { value: user.id, label: user.login_id };
  });
  userOption.unshift({ label: "user", value: null });
  const onUserHandler = (event) => {
    setCondition({ label: condition.label, milestone: condition.milestone, user: event.value });
  };
  return (
    <Styled>
      <ModalDropdown options={userOption} value={null} onChange={onUserHandler} placeholder="user" />
    </Styled>
  );
}

export default hot(module)(UserDropdown);
