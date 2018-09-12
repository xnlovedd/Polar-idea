package polar.island.core.util;

import org.apache.commons.io.IOUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import polar.island.core.excell.DefaultExportDecorate;
import polar.island.core.excell.DefaultExportDecorate.ExcellField;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExcellUtil {
    private ExcellUtil() {

    }

    /**
     * 获取导入数据
     *
     * @param <T>      数据类型
     * @param datas    导入数据
     * @param decorate 构造器
     * @param classes  类的类型
     * @return 获取到的导入数据
     * @throws Exception 异常信息
     */
    private static <T> List<Map<String, Object>> getImportData(List<List<String>> datas,
                                                               DefaultExportDecorate<T> decorate, Class<? extends T> classes) throws Exception {
        // 获取导入的列
        List<ExcellField> fields = decorate.getImportFields(classes);
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        for (List<String> columns : datas) {
            Map<String, Object> t = new HashMap<String, Object>();
            int i = 0;
            for (ExcellField field : fields) {
                decorate.formatImportField(field, columns.get(i), t, classes);
                i++;
            }
            result.add(t);
        }
        return result;
    }

    public static <T> List<Map<String, Object>> importExcell(InputStream is, DefaultExportDecorate<T> decorate,
                                                             Class<? extends T> classes) throws Exception {
        List<String> titles = getExportTitle(decorate, classes);
        List<List<String>> datas = new ArrayList<List<String>>();
        HSSFWorkbook workbook = null;
        try {
            workbook = new HSSFWorkbook(is);
            HSSFSheet sheet = workbook.getSheetAt(0);
            // 第一行为列头，忽略
            for (int i = 1; i < sheet.getLastRowNum() + 1; i++) {
                List<String> data = new ArrayList<String>();
                HSSFRow row = sheet.getRow(i);
                for (int j = 0; j < titles.size(); j++) {
                    HSSFCell cell = row.getCell(j);
                    data.add(getStringCellValue(cell));
                }
                datas.add(data);
            }
        } finally {
            IOUtils.closeQuietly(is);
            IOUtils.closeQuietly(workbook);
        }
        return getImportData(datas, decorate, classes);
    }

    private static String getStringCellValue(HSSFCell cell) {
        String strCell = "";
        switch (cell.getCellTypeEnum()) {
            case STRING:
                strCell = cell.getStringCellValue();
                break;
            case NUMERIC:
                strCell = CommonUtil.valueOf(cell.getNumericCellValue());
                break;
            case BOOLEAN:
                strCell = CommonUtil.valueOf(cell.getBooleanCellValue());
                break;
            case BLANK:
                strCell = null;
                break;
            default:
                strCell = null;
                break;
        }
        if (strCell != null && strCell.length() == 0) {
            strCell = null;
        }
        return strCell;
    }

    public static <T> void importExcellMode(DefaultExportDecorate<T> decorate, Class<? extends T> classes, OutputStream outputStream)
            throws Exception {
        List<String> titles = getExportTitle(decorate, classes);
        List<ExcellField> fields = decorate.getExportFields(classes);

        HSSFWorkbook workbook = null;
        try {

            // 创建excel文件，注意这里的hssf是excel2007及以前版本可用，2007版以后的不可用，要用xssf
            workbook = new HSSFWorkbook();
            // 创建excel工作表
            HSSFSheet sheet = workbook.createSheet("Sheet");
            // 开始写出头部
            HSSFRow titleRow = sheet.createRow(0);
            HSSFCellStyle style = workbook.createCellStyle();
            style.setAlignment(HorizontalAlignment.CENTER);
            style.setVerticalAlignment(VerticalAlignment.CENTER);
            style.setAlignment(HorizontalAlignment.CENTER);
            HSSFFont font = workbook.createFont();
            font.setFontName("宋体");
            font.setBold(true);
            font.setFontHeightInPoints((short) 12);// 设置字体大小
            style.setFont(font);
            style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            short cellHeight = 400;
            titleRow.setHeight(cellHeight);
            for (int i = 0; i < titles.size(); i++) {
                String title = titles.get(i);
                sheet.setColumnWidth(i, fields.get(i).getWidth());
                HSSFCell cell = titleRow.createCell(i);
                cell.setCellStyle(style);
                cell.setCellValue(title == null ? "" : title);
            }
            // 调用输出流把excel文件写入到磁盘
            workbook.write(outputStream);
        } finally {
            IOUtils.closeQuietly(outputStream);
            IOUtils.closeQuietly(workbook);
        }
    }

    public static <T> void exportExcell(List<? extends Object> lists, DefaultExportDecorate<T> decorate,
                                          Class<? extends T> classes, OutputStream outputStream) throws Exception {
        List<String> titles = getExportTitle(decorate, classes);
        List<ExcellField> fields = decorate.getExportFields(classes);
        List<List<String>> datas = getExportData(lists, decorate, classes);

        HSSFWorkbook workbook = null;
        try {
            // 创建excel文件，注意这里的hssf是excel2007及以前版本可用，2007版以后的不可用，要用xssf
            workbook = new HSSFWorkbook();
            // 创建excel工作表
            HSSFSheet sheet = workbook.createSheet("Sheet");
            // 开始写出头部
            HSSFRow titleRow = sheet.createRow(0);
            HSSFCellStyle style = workbook.createCellStyle();
            style.setAlignment(HorizontalAlignment.CENTER);
            style.setVerticalAlignment(VerticalAlignment.CENTER);
            style.setAlignment(HorizontalAlignment.CENTER);
            HSSFFont font = workbook.createFont();
            font.setFontName("宋体");
            font.setBold(true);
            font.setFontHeightInPoints((short) 12);// 设置字体大小
            style.setFont(font);
            style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            short cellHeight = 400;
            titleRow.setHeight(cellHeight);
            for (int i = 0; i < titles.size(); i++) {
                String title = titles.get(i);
                sheet.setColumnWidth(i, fields.get(i).getWidth());
                HSSFCell cell = titleRow.createCell(i);
                cell.setCellStyle(style);
                cell.setCellValue(title == null ? "" : title);
            }
            // 开始写出数据
            for (int i = 0; i < datas.size(); i++) {
                List<String> rows = datas.get(i);
                HSSFRow row = sheet.createRow(i + 1);
                for (int j = 0; j < rows.size(); j++) {
                    String value = rows.get(j);
                    row.createCell(j).setCellValue(value == null ? "" : value);
                }
            }
            // 调用输出流把excel文件写入到磁盘
            workbook.write(outputStream);
        } finally {
            IOUtils.closeQuietly(outputStream);
            IOUtils.closeQuietly(workbook);
        }
    }


    /**
     * 获取导出的数据
     *
     * @param <T>      数据泛化类型
     * @param lists    需要导出的数据
     * @param decorate 修饰器
     * @param classes  导出的实体类型
     * @return 导出的数据
     * @throws Exception 异常信息
     */
    private static <T> List<List<String>> getExportData(List<? extends Object> lists, DefaultExportDecorate<T> decorate,
                                                        Class<? extends T> classes) throws Exception {
        List<ExcellField> fields = decorate.getExportFields(classes);
        // 导出数据
        List<List<String>> result = new ArrayList<List<String>>();
        for (Object entity : lists) {
            List<String> args = new ArrayList<String>();
            for (ExcellField field : fields) {
                String value = decorate.getExportValue(field, entity, classes);
                args.add(value);
            }
            result.add(args);
        }
        return result;
    }

    /**
     * 获取导出的标题
     *
     * @param <T>      数据泛化类型
     * @param decorate 修饰器
     * @param classes  导出的实体类型
     * @return 导出的标题
     * @throws Exception 异常信息
     */
    private static <T> List<String> getExportTitle(DefaultExportDecorate<T> decorate, Class<? extends T> classes)
            throws Exception {
        List<ExcellField> fields = decorate.getExportFields(classes);
        // 导出数据
        List<String> result = new ArrayList<String>();
        for (ExcellField field : fields) {
            result.add(field.getTitle());
        }
        return result;
    }
}
