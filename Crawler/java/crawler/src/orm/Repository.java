package orm;

import java.util.List;

/**
 * Created by Nikit on 17.03.2016.
 */
public class Repository<T> implements RepositoryInterface<T> {

    @Override
    public List<T> getAll() {
        return null;
    }

    @Override
    public boolean save(T entity) {
        return false;
    }

    @Override
    public boolean delete(int id) {
        return false;
    }

    @Override
    public boolean delete(T entity) {
        return false;
    }
}
