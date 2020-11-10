import React, { useEffect, useState } from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import LabelList from "@component/labelListPage/element/labelList";
import MoveToCreateLabelButton from "../component/labelListPage/buttons/moveToCreateLabelButton";
import MoveToLabelButton from "../component/labelListPage/buttons/moveToLabelButton";
import MoveToMaileStoneButton from "../component/labelListPage/buttons/moveToMilestoneButton";
import LabelFilter from "../component/labelListPage/filter/labelFilter";
import CreateLabelDropdown from "../component/labelListPage/dropdown/createLabelDropdown";

import axiosApi from "../util/axiosApi";

const StyledLabelListPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
  flex-direction: column;
`;
const Header = styled.div`
  display: flex;
  flex-direction: row;
  flex: 2 3 5;
`;
const Combination = styled.div`
  display: flex;
  flex-direction: row;
`;
const Body = styled.div`
  display: flex;
  flex-direction: column;
`;
function LabelListPage() {
  const [labels, setLabels] = useState([]);
  const [visible, setVisible] = useState("none");
  useEffect(async () => {
    const response = await axiosApi("/label", "GET");
    setLabels(response.data);
  }, []);

  const Dropdown = () => {
    if (visible === "none") {
      setVisible("flex");
    } else {
      setVisible("none");
    }
  };
  return (
    <StyledLabelListPage>
      <Header>
        <Combination>
          <MoveToLabelButton />
          <MoveToMaileStoneButton />
        </Combination>
        <LabelFilter />
        <MoveToCreateLabelButton event={Dropdown} />
      </Header>
      <Body>
        <CreateLabelDropdown visible={visible} event={Dropdown} setLabels={setLabels} />
        <LabelList labels={labels} setLabels={setLabels} />
      </Body>
    </StyledLabelListPage>
  );
}

export default hot(module)(LabelListPage);
