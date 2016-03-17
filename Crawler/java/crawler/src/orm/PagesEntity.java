package orm;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Nikit on 17.03.2016.
 */
@Entity
@Table(name = "pages", schema = "ratefinder", catalog = "")
public class PagesEntity {
    private int id;
    private String url;
    private int siteId;
    private Timestamp foundDateTime;
    private Serializable lastScanDate;

    @Basic
    @Column(name = "ID")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "Url")
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Basic
    @Column(name = "SiteID")
    public int getSiteId() {
        return siteId;
    }

    public void setSiteId(int siteId) {
        this.siteId = siteId;
    }

    @Basic
    @Column(name = "FoundDateTime")
    public Timestamp getFoundDateTime() {
        return foundDateTime;
    }

    public void setFoundDateTime(Timestamp foundDateTime) {
        this.foundDateTime = foundDateTime;
    }

    @Basic
    @Column(name = "LastScanDate")
    public Serializable getLastScanDate() {
        return lastScanDate;
    }

    public void setLastScanDate(Serializable lastScanDate) {
        this.lastScanDate = lastScanDate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PagesEntity that = (PagesEntity) o;

        if (id != that.id) return false;
        if (siteId != that.siteId) return false;
        if (url != null ? !url.equals(that.url) : that.url != null) return false;
        if (foundDateTime != null ? !foundDateTime.equals(that.foundDateTime) : that.foundDateTime != null)
            return false;
        if (lastScanDate != null ? !lastScanDate.equals(that.lastScanDate) : that.lastScanDate != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (url != null ? url.hashCode() : 0);
        result = 31 * result + siteId;
        result = 31 * result + (foundDateTime != null ? foundDateTime.hashCode() : 0);
        result = 31 * result + (lastScanDate != null ? lastScanDate.hashCode() : 0);
        return result;
    }
}
