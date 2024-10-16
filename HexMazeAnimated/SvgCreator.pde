import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

public class SvgCreator {
    private BufferedWriter writer;
    private StringBuilder svgContent;
    private final String filePath;

    // Constructor to initialize the SVG file
    public SvgCreator(String fileName, int width, int height) throws IOException {
        filePath = fileName;
        svgContent = new StringBuilder();
        svgContent.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
        svgContent.append("<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"")
                .append(width).append("\" height=\"").append(height).append("\">\n");
    }

    // Function to initialize the file
    public void initSvgFile() throws IOException {
        writer = new BufferedWriter(new FileWriter(filePath));
    }

    // Helper function to add metadata
    public void addMetadata(String title, String description) {
        svgContent.append("<title>").append(title).append("</title>\n")
                .append("<desc>").append(description).append("</desc>\n");
    }

    // Function to add a line to the SVG content
    public void addLine(int x1, int y1, int x2, int y2, String strokeColor, int strokeWidth) {
        svgContent.append("<line x1=\"").append(x1).append("\" y1=\"").append(y1)
                .append("\" x2=\"").append(x2).append("\" y2=\"").append(y2)
                .append("\" stroke=\"").append(strokeColor).append("\" stroke-width=\"")
                .append(strokeWidth).append("\" />\n");
    }
    
    // Function to add a line to the SVG content
    public void addLineList(Line l) {
        svgContent.append("<line x1=\"").append(l.x1).append("\" y1=\"").append(l.y1)
                .append("\" x2=\"").append(l.x2).append("\" y2=\"").append(l.y2)
                .append("\" stroke=\"").append(l.strokeColor).append("\" stroke-width=\"")
                .append(l.strokeWidth).append("\" />\n");
    }

    // Function to add a rectangle
    public void addRectangle(int x, int y, int width, int height, String fillColor, String strokeColor, int strokeWidth) {
        svgContent.append("<rect x=\"").append(x).append("\" y=\"").append(y)
                .append("\" width=\"").append(width).append("\" height=\"").append(height)
                .append("\" fill=\"").append(fillColor).append("\" stroke=\"")
                .append(strokeColor).append("\" stroke-width=\"").append(strokeWidth)
                .append("\" />\n");
    }

    // Function to add a circle
    public void addCircle(int cx, int cy, int r, String fillColor, String strokeColor, int strokeWidth) {
        svgContent.append("<circle cx=\"").append(cx).append("\" cy=\"").append(cy)
                .append("\" r=\"").append(r).append("\" fill=\"").append(fillColor)
                .append("\" stroke=\"").append(strokeColor).append("\" stroke-width=\"")
                .append(strokeWidth).append("\" />\n");
    }

    // Function to add a polygon from a list of PVectors
    public void addPolygon(List<PVector> points, String fillColor, String strokeColor, int strokeWidth) {
        if (points.size() < 3) {
            throw new IllegalArgumentException("A polygon must have at least 3 points");
        }

        svgContent.append("<polygon points=\"");
        for (PVector point : points) {
            svgContent.append(point.x).append(",").append(point.y).append(" ");
        }
        svgContent.append("\" fill=\"").append(fillColor).append("\" stroke=\"")
                .append(strokeColor).append("\" stroke-width=\"").append(strokeWidth)
                .append("\" />\n");
    }

    // Finish the file and write the content to disk
    public void finishSvgFile() throws IOException {
        svgContent.append("</svg>");
        writer.write(svgContent.toString());
        writer.close();
    }
}
