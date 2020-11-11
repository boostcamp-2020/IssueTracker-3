import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Select, MenuItem } from "@material-ui/core";
import axiosApi from "../../../util/axiosApi";

const Styled = styled.div`
  display: flex;
  width: 100%;
  justify-content: flex-end;
`;

function CheckFilter(props) {
  const { checked } = props;
  const onCheckedHandler = async (event) => {
    for (const issue of checked) {
      await axiosApi(`/issue/${issue}/state/${event.target.value}`, "PATCH");
    }
  };
  return (
    <Styled>
      <span>{checked.length}</span>
      <Select defaultValue="none" onChange={onCheckedHandler}>
        <MenuItem value="none" disabled>
          Mark as
        </MenuItem>
        <MenuItem value={1}>open</MenuItem>
        <MenuItem value={0}>close</MenuItem>
      </Select>
    </Styled>
  );
}

export default hot(module)(CheckFilter);
