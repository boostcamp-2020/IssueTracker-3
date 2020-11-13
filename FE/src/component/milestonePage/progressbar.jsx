import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledProgressbar = styled.div`
  width: 100%;
  background-color: #b2bec3;
`;

function Progressbar({ percent }) {
  return (
    <StyledProgressbar>
      <div style={{ width: `${percent}%`, height: 40, backgroundColor: `blue` }}></div>
    </StyledProgressbar>
  );
}
export default hot(module)(Progressbar);
