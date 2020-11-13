import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledInformation = styled.div`
  margin: 5px 0px;
`;

const InformationSpan = styled.span`
  font-size: 14px;
  font-weight: 600;
  margin: 0px 7px;
`;

function Information({ percent, open, close }) {
  return (
    <StyledInformation>
      <InformationSpan>{percent}%</InformationSpan>
      <InformationSpan>{open}open</InformationSpan>
      <InformationSpan>{close}close</InformationSpan>
    </StyledInformation>
  );
}

export default hot(module)(Information);
