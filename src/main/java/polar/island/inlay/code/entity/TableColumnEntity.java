package polar.island.inlay.code.entity;

import javax.validation.Valid;
import java.util.List;

public class TableColumnEntity {
	private Long tableId;
	@Valid
	private List<CodeColumn> list;
	public List<CodeColumn> getList() {
		return list;
	}
	public void setList(List<CodeColumn> list) {
		this.list = list;
	}
	public Long getTableId() {
		return tableId;
	}
	public void setTableId(Long tableId) {
		this.tableId = tableId;
	}
	
}
