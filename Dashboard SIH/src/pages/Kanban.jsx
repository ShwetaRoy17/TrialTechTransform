import React from 'react';
import { KanbanComponent, ColumnsDirective, ColumnDirective } from '@syncfusion/ej2-react-kanban';
import Navbar from '../components/Navbar';
import { kanbanData, kanbanGrid } from '../data/dummy';
import { Header } from '../components';

const Kanban = () => (
  <div className=" md:mr-10 md:ml-10 md:mb-10 mt-2 md:pr-10 md:pl-10 bg-white rounded-3xl">
    <div className="fixed md:static bg-main-bg dark:bg-main-dark-bg navbar w-full ">
      <Navbar />
    </div>
    <Header category="App" title="To-do List" />
    <KanbanComponent
      id="kanban"
      keyField="Status"
      dataSource={kanbanData}
      cardSettings={{ contentField: 'Summary', headerField: 'Id' }}
    >
      <ColumnsDirective>
        {/* eslint-disable-next-line react/jsx-props-no-spreading */}
        {kanbanGrid.map((item, index) => <ColumnDirective key={index} {...item} />)}
      </ColumnsDirective>
    </KanbanComponent>
  </div>
);
export default Kanban;
