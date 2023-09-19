import React from 'react';
import { GridComponent, Inject, ColumnsDirective, ColumnDirective, Search, Page } from '@syncfusion/ej2-react-grids';
import Navbar from '../components/Navbar';
import { employeesData, employeesGrid } from '../data/dummy';
import { Header } from '../components';

const Lawyers = () => {
  const toolbarOptions = ['Search'];

  const editing = { allowDeleting: true, allowEditing: true };

  return (
    <div className="md:mr-10 md:ml-10 mt-2 md:pr-10 md:pl-10 bg-white rounded-3xl">
      <div className="fixed md:static bg-main-bg dark:bg-main-dark-bg navbar w-full ">
        <Navbar />
      </div>
      <Header category="Page" title="Lawyers" />
      <GridComponent
        dataSource={employeesData}
        width="auto"
        allowPaging
        allowSorting
        pageSettings={{ pageCount: 5 }}
        editSettings={editing}
        toolbar={toolbarOptions}
      >
        <ColumnsDirective>
          {/* eslint-disable-next-line react/jsx-props-no-spreading */}
          {employeesGrid.map((item, index) => <ColumnDirective key={index} {...item} />)}
        </ColumnsDirective>
        <Inject services={[Search, Page]} />

      </GridComponent>
    </div>
  );
};
export default Lawyers;
