export class LibraryListDataSource implements IDataSource {
  private dataList: string[] = []
  private listener: DataChangeListener | null = null

  constructor(list: string[]) {
    this.dataList = list
  }
  totalCount(): number {
    return this.dataList.length
  }

  getData(index: number): string {
    return this.dataList[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = this.listener
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    this.listener = null
  }
}