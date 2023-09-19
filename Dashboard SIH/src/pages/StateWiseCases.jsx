import React, { useState } from 'react';
import {
  GridComponent,
  ColumnsDirective,
  ColumnDirective,
  Page,
  Selection,
  Inject,
  Edit,
  Toolbar,
  Sort,
  Filter,
} from '@syncfusion/ej2-react-grids';
import Navbar from '../components/Navbar';
import { customersData, customersGrid } from '../data/dummy';
import { Header } from '../components';

const StateWiseCases = () => {
  const selectionsettings = { persistSelection: true };
  const toolbarOptions = ['Delete'];
  const editing = { allowDeleting: true, allowEditing: true };
  const [selectState, setSelectState] = useState('Gujrat High Court');

  const stateChangeHandler = (event) => {
    setSelectState(event.target.value);
  };

  const uniqueStates = new Set();
  customersData.forEach((i) => uniqueStates.add(i.Location));
  const uniqueStatesArray = Array.from(uniqueStates);
  console.log('ARRAY ', uniqueStatesArray);
  console.log('STATE ', selectState);

  return (
    <div className="md:mr-10 md:ml-10 mt-2 md:pr-10 md:pl-10 bg-white rounded-3xl">
      <div className="fixed md:static bg-main-bg dark:bg-main-dark-bg navbar w-full">
        <Navbar />
      </div>
      <Header category="Page" title="State Wise Cases" />
      <select id="category" name="category" onChange={stateChangeHandler}>
        {uniqueStatesArray.map((states) => (
          <option key={states} value={states}>
            {states}
          </option>
        ))}
      </select>
      <GridComponent
        dataSource={customersData.filter((data) => data.Location === selectState)}
        enableHover={false}
        allowPaging
        pageSettings={{ pageCount: 5 }}
        selectionSettings={selectionsettings}
        toolbar={toolbarOptions}
        editSettings={editing}
        // allowSorting
      >
        <ColumnsDirective>
          {/* eslint-disable-next-line react/jsx-props-no-spreading */}
          {customersGrid.map((item, index) => (
            <ColumnDirective key={index} {...item} />
          ))}
        </ColumnsDirective>
        <Inject services={[Page, Selection, Toolbar, Edit, Sort, Filter]} />
      </GridComponent>
    </div>
  );
};

export default StateWiseCases;
